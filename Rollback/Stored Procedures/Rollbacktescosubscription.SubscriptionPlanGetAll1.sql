IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[SubscriptionPlanGetAll1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[SubscriptionPlanGetAll1] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[SubscriptionPlanGetAll1] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[SubscriptionPlanGetAll1] - Not exists'
	END 
GO

 