/*
	Author:		Robin
	Created:	27 Jun 2013
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerSubscriptionsGet1]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerSubscriptionsGet1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionsGet1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerSubscriptionsGet1] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerSubscriptionsGet1] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerSubscriptionsGet1] - Not exists'
	END 
GO



