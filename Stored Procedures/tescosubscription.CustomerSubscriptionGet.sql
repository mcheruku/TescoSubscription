IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet] not dropped.',16,1)
			END
	END
GO

CREATE PROCEDURE [tescosubscription].[CustomerSubscriptionGet]
	(@CustomerSubscriptionID BIGINT)
AS
/*
Author:		Robin
Create date: 10 - Feb - 2013
Purpose: To get the customer subscription
Called by:		DS and Juvo

--Modifications History--
Changed On		Changed By		Defect Ref		Change Description
 
*/

BEGIN	
	SET NOCOUNT ON;

	SELECT [CustomerSubscriptionID]
      ,[CustomerID]
      ,[SubscriptionPlanID]
      ,[CustomerPlanStartDate]
      ,[CustomerPlanEndDate]
      ,[NextRenewalDate]
      ,[SubscriptionStatus]
      ,[PaymentProcessStatus]
      ,[RenewalReferenceDate]
      ,[EmailSentRenewalDate]
      ,[UTCCreatedDateTime]
      ,[UTCUpdatedDateTime]
      ,[SwitchCustomerSubscriptionID]
      ,[SwitchTo]
	FROM [TescoSubscription].[tescosubscription].[CustomerSubscription](NOLOCK)
	WHERE [CustomerSubscriptionID] = @CustomerSubscriptionID
END


GO

--Grant execute permissions as required by any calling application.
GRANT EXECUTE ON [tescosubscription].[CustomerSubscriptionGet] TO [SubsUser]
GO

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet]',N'P') IS NOT NULL
	BEGIN
		PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionGet] created.'
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionGet] not created.',16,1)
	END
GO


