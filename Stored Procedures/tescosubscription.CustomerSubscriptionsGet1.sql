IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionsGet1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet1] not dropped.',16,1)
			END
	END 
GO


CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionsGet1]
(
	@CustomerID BIGINT,
	@Top TINYINT =3
)
AS

/*

	Author:			Robin
	Date created:	22/05/2013
	Purpose:		Returns Customer subscription Details	
	Behaviour:		How does this procedure actually work
	Usage:			
	Called by:		<JUVO>/<DS>
	--exec [tescosubscription].[CustomerSubscriptionsGet1] 72723194,100

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
   30 May 2013      Robin                           Added Case logic to NextPaymentDate 	
*/

	BEGIN
	
	  SET NOCOUNT ON
		SELECT  TOP (@Top)
			CS.CustomerSubscriptionID  CustomerSubscriptionID,
			CS.SubscriptionPlanID	   PlanSubscriptionID,
			CS.SwitchTo				   SwitchTo,
			SP.PlanName				   PlanName,
			CS.CustomerPlanStartDate   SubscriptionStartDate,
			CS.CustomerPlanEndDate     SubscriptionEndDate,
			SM.StatusName              Status,
			SP.PlanName				   PlaneName,
			SP.PlanTenure			   PlanTenure,
			SP.PlanAmount			   PlanAmount,
			CS.NextRenewalDate		   NextRenewalDate,
			CS.SwitchCustomerSubscriptionID SwitchCustomerSubscriptionID,	
            ISNULL(CS.NextPaymentDate, CS.NextRenewalDate) NextPaymentDate,
	        CASE WHEN CS.NextPaymentDate IS NULL THEN 0 ELSE ISNULL(DATEDIFF(M,CS.NextPaymentDate,CS.NextRenewalDate)/IP.InstallmentTenure,0) END RemainingInstallments					
		FROM tescosubscription.CustomerSubscription CS (NOLOCK)
		INNER JOIN tescosubscription.SubscriptionPlan SP (NOLOCK)  ON CS.SubscriptionPlanID = SP.SubscriptionPlanID
		INNER JOIN tescosubscription.StatusMaster  SM (NOLOCK) ON CS.SubscriptionStatus=SM.StatusId
        INNER JOIN tescosubscription.PaymentInstallment IP (NOLOCK) ON Sp.PaymentInstallmentID = IP.PaymentInstallmentID 
        WHERE CS.CustomerID = @CustomerID
        AND CS.SubscriptionStatus <> 15
		ORDER BY  CS.UTCUpdatedDateTime desc
	END
	

GO

	--Grant execute permissions as required by any calling application.
	GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionsGet1] TO [SubsUser]
	GO


	IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NOT NULL
		BEGIN
			PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionsGet1] created.'
		END
	ELSE
		BEGIN
			RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionsGet1] not created.',16,1)
		END
	GO




