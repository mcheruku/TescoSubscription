/*
	Author:		Robin
	Created:	27 Jun 2013
	Purpose:	This script to drop the procedure [tescosubscription].[NotificationDetailsGet1]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[NotificationDetailsGet1]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[NotificationDetailsGet1]

		IF OBJECT_ID(N'[tescosubscription].[NotificationDetailsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[NotificationDetailsGet1] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[NotificationDetailsGet1] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[NotificationDetailsGet1] - Not exists'
	END 
GO



