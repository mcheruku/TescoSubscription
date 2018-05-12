/*
	Author:		Saritha K
	Created:	04 Aug 2011
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerSubscriptionPlanGet]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPlanGet]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerSubscriptionPlanGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionPlanGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerSubscriptionPlanGet] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerSubscriptionPlanGet] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerSubscriptionPlanGet] - Not exists'
	END 
GO



