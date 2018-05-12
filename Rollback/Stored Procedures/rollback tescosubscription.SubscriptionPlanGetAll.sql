/*
	Author:		Saritha K
	Created:	28 jul 2011
	Purpose:	This script to drop the procedure [tescosubscription].[SubscriptionPlanGetAll]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[SubscriptionPlanGetAll]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[SubscriptionPlanGetAll] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[SubscriptionPlanGetAll] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[SubscriptionPlanGetAll] - Not exists'
	END 
GO



