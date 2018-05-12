/*
	Author:		Robin
	Created:	27 Jun 2013
	Purpose:	This script to drop the procedure [tescosubscription].[SubscriptionPlanDetailsGet2]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet2]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[SubscriptionPlanDetailsGet2]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsGet2]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[SubscriptionPlanDetailsGet2] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[SubscriptionPlanDetailsGet2] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[SubscriptionPlanDetailsGet2] - Not exists'
	END 
GO



