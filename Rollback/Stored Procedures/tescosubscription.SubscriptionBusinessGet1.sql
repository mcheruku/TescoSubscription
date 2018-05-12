/*
	Author:		Robin John
	Created:	05 Dec 2012
	Purpose:	This script to drop the procedure [tescosubscription].[SubscriptionBusinessGet1]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet1]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[SubscriptionBusinessGet1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionBusinessGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[SubscriptionBusinessGet1] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[SubscriptionBusinessGet1] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[SubscriptionBusinessGet1] - Not exists'
	END 
GO
