/*
	Author:		Saritha K
	Created:	04 Aug 2011
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerNotificationDetailsGet]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE [tescosubscription].[CustomerNotificationDetailsGet]

		IF OBJECT_ID(N'[tescosubscription].[CustomerNotificationDetailsGet]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerNotificationDetailsGet] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerNotificationDetailsGet] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerNotificationDetailsGet] - Not exists'
	END 
GO



