/*
	Author:		Saritha K
	Created:	08 Sep 2011
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerSubscriptionHistoryGet]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 



IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistoryGet]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerSubscriptionHistoryGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistoryGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerSubscriptionHistoryGet] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerSubscriptionHistoryGet] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerSubscriptionHistoryGet] - Not exists'
	END 
GO



