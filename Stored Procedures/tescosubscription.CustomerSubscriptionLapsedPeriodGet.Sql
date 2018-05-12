IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionLapsedPeriodGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] not dropped.',16,1)
			END
	END
GO




CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] 	
	@CustomerId BIGINT,
	@SubscriptionLapsedPeriod INT Output 	
AS
/*
	Author:		 Lavanya
	Create date: 04/10/2012
	Description: Get the customer subscription lapsed period

		--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	11-Oct-2012     Lavanya                          MOdified to new customer to use coupon
	25-Oct-2012	Manjunathan Raman		To handle False Cancelled Subscriptions (System Cancelled)


*/
BEGIN
	
	SET NOCOUNT ON;
	SELECT @SubscriptionLapsedPeriod = ISNULL(datediff(day, MAX(CustomerPlanEndDate), Getdate()),-1)
	FROM tescosubscription.CustomerSubscription CS (NOLOCK)
	JOIN tescosubscription.CustomerPaymentHistory CPH (NOLOCK)
	 ON  CPH.CustomerSubscriptionID=CS.CustomerSubscriptionID                                                                          
	JOIN  tescosubscription.CustomerPaymentHistoryResponse CPHR (NOLOCK)
	 ON  CPH.CustomerPaymentHistoryID	   =     CPHR.CustomerPaymentHistoryID  
		AND PaymentStatusID=1
	WHERE 
		subscriptionstatus in (9,10)
		and CustomerID = @CustomerId

	/*
		9 - Cancelled
		10 - Stopped
	*/
END


GO

GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] TO [SubsUser] AS [dbo]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionLapsedPeriodGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionLapsedPeriodGet] not created.',16,1)
	END
GO
