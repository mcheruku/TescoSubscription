/*
	Author:		Saritha K
	Created:	28 jul 2011
	Purpose:	This script to drop the procedure [tescosubscription].[subscriptionPlanDetailsGet]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[subscriptionPlanDetailsGet]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[subscriptionPlanDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[subscriptionPlanDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[subscriptionPlanDetailsGet] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[subscriptionPlanDetailsGet] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[subscriptionPlanDetailsGet] - Not exists'
	END 
GO



