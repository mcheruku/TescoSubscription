/*
	Author:		Robin
	Created:	27 Jun 2013
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerSubscriptionGet1]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet1]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerSubscriptionGet1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerSubscriptionGet1] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerSubscriptionGet1] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerSubscriptionGet1] - Not exists'
	END 
GO



