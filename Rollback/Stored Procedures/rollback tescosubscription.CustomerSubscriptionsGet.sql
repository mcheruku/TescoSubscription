/*
	Author:		Saritha K
	Created:	04 Aug 2011
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerSubscriptionsGet]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerSubscriptionsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerSubscriptionsGet] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerSubscriptionsGet] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerSubscriptionsGet] - Not exists'
	END 
GO



