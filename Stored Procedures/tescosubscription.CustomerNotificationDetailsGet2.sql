set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go



ALTER PROCEDURE [tescosubscription].[CustomerNotificationDetailsGet2] 
AS
 
/*  Author:			Thulasi 
	Date created:	9 Aug 2011
	Purpose:		1)To check if any active subscriptions' payment card details are due to expire that month before 7 days of payment due date
					  and also to send a reminder mail for the payment due within 7 days.
					2)To send a Email to the customer after every successful or failed recurring payment.
	Behaviour:		1)Gets the Payment token of Customers associated with an Active Subscription before 7 days of payment due date
					2)Gets the Customer Subscription Updated Details after the Recurring Payment Process is completed.
	Usage:			Everyday
	Called by:		NotifyCustomerSubscription [SSIS Package]
	

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
     26 Aug 2011	Manjunathan						Email select based on flag	 
     15 Sep 2011	Thulasi							Remove hard coding of Channel name, 
													Removed Business. Business and Language is configurable in the SSIS config file.
	 16 Sep	2011	Thulasi							Not sending the status 'SystemFailure' for notifications.
	 19 Sep 2011	Thulasi							Remove Channel name, And Channel is configured in SSIS package
	 30 Sep 2011	Thulasi							Added the logic to calculate and send next renewal date in case the payment is made and update has not occurred.
     10 Jan 2013    Robin                           Added logic For plan Switch
     25 Feb 2013    Robin                           Added logic to get old subscriptionplanid and CS.SwitchTo IS NOT NULL
     10 Jun 2013    Robin                           Changed the version and added logic for montly card expiry and versioned
     20 May 2013    Deepmala                        Versioned and changed as per D7 release 
     2 March 2015   Robin                           Added the logic to pick the 7 days reminder email isted of 6 days
*/

BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE
			 @CurrentDate DATETIME	
			,@NotifyPeriod TINYINT -- no. of days before which notification has to be sent for expired cards
			,@SuccessPaymentProcessStatus TINYINT 
			,@InProgressPaymentProcessStatus TINYINT 
			,@ActiveSubscriptionStatus TINYINT
			,@RecurringChannelID	TINYINT
			,@SystemFailureStatusID TINYINT
			,@PendingStopStatus TINYINT
				
			
 
	SELECT @NotifyPeriod = 7
		   ,@CurrentDate = GETDATE()	
		   ,@SuccessPaymentProcessStatus = 6 
		   ,@InProgressPaymentProcessStatus = 5	
		   ,@ActiveSubscriptionStatus = 8
		   ,@RecurringChannelID = 2	
		   ,@SystemFailureStatusID = 3
		   ,@PendingStopStatus=11		   
 --	hard coded values are stored in variables for ease of future changes if any.
	
	SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE  
		   WHEN (CS.SwitchTo IS NULL) then  'Payment Reminder' 
	       WHEN (CS.SubscriptionStatus = @PendingStopStatus ) then  'Switched-Pending Stop' 
	       ELSE 'Switched'  END StatusName
           ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
	FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
                                                    AND CS.NextRenewalDate <= CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(DAY, @NotifyPeriod, @CurrentDate),101)+' 23:59:59')
												 -- AND CS.NextRenewalDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
                									AND CS.NextRenewalDate <> CS.EmailSentRenewalDate  --check flag 
													AND (CS.NextRenewalDate <  CONVERT(DATETIME,CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101) ) 
															OR CS.SwitchTo IS NOT NULL) -- no notification is needed if the subscription is about to end
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus OR 
                                                        (CS.SubscriptionStatus = @PendingStopStatus AND CS.SwitchTo IS NOT NULL))
                                                    
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
													AND SP.PaymentInstallmentID = 1
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID
				
	UNION ALL  

    SELECT 
		  CS.[CustomerSubscriptionID] TransactionID, 
		  CS.CustomerID
		  ,CCM.CountryCode
		  ,CP.[PaymentToken] -- The Expiry date has to be extracted from the payment Token
		  ,CS.[SubscriptionPlanID] -- needed to get the right terms and conditions URL and other details are fetched from ID	
		  ,CS.NextRenewalDate AS [NextRenewalDate]
          ,CASE	WHEN (CS.SwitchTo IS NULL) then  'Payment Reminder' -- Status Pending stop and Active
				WHEN (CS.SubscriptionStatus = @PendingStopStatus And CS.SwitchTo IS NOT NULL) then  'Switched-Pending Stop'
				ELSE  'Switched' END StatusName
		  ,COALESCE(CS.SwitchTo, 0)	 SwitchTo
    FROM tescosubscription.CustomerSubscription CS
		JOIN tescosubscription.Customerpayment CP	ON CP.CustomerID =	CS.CustomerID
													AND CP.PaymentModeID=1
													AND CP.IsActive = 1
                                                  --AND CS.NextPaymentDate <= DATEADD(DAY, @NotifyPeriod, @CurrentDate)
													AND CS.NextPaymentDate <= CONVERT(DATETIME,CONVERT(VARCHAR(10),DATEADD(DAY, @NotifyPeriod,@CurrentDate),101)+' 23:59:59')
                									AND CS.NextPaymentDate <> CS.EmailSentRenewalDate  --check flag 
													AND (CS.NextPaymentDate  <  CONVERT(DATETIME,CONVERT(VARCHAR(10),CS.CustomerPlanEndDate,101)) -- no notification is needed if the subscription is about to end
															OR CS.SwitchTo IS NOT NULL)
													AND (CS.SubscriptionStatus = @ActiveSubscriptionStatus or CS.SubscriptionStatus = @PendingStopStatus )
		JOIN tescosubscription.SubscriptionPlan SP		ON CS.SubscriptionPlanID		=	SP.SubscriptionPlanID
													AND SP.PaymentInstallmentID <> 1
		JOIN tescosubscription.CountryCurrencyMap CCM	ON CCM.CountryCurrencyID		=	SP.CountryCurrencyID

       ORDER BY CS.CustomerID
	 
END



