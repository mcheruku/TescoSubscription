/*
	Author:		Saritha K
	Created:	09 Aug 2011
	Purpose:	This script to drop the procedure [tescosubscription].[SubscriptionPlanDetailsUpdate]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[SubscriptionPlanDetailsUpdate]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[SubscriptionPlanDetailsUpdate] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[SubscriptionPlanDetailsUpdate] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[SubscriptionPlanDetailsUpdate] - Not exists'
	END 
GO



