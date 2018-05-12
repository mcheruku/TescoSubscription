/*
	Author:		Robin
	Created:	27 Jun 2013
	Purpose:	This script to drop the procedure [tescosubscription].[CustomerSubscriptionSwitchDueRenewal1]

	--Modifications History--
 
	Changed On		Changed By		Defect	Change Description 
	

*/ 
	

IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchDueRenewal1]',N'P') IS NOT NULL
	BEGIN
		DROP PROCEDURE[tescosubscription].[CustomerSubscriptionSwitchDueRenewal1]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchDueRenewal1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS: Stored Procedure: [tescosubscription].[CustomerSubscriptionSwitchDueRenewal1] - dropped'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL: Stored Procedure: [tescosubscription].[CustomerSubscriptionSwitchDueRenewal1] - was not dropped',16,1)	
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS : Stored Procedure: [tescosubscription].[CustomerSubscriptionSwitchDueRenewal1] - Not exists'
	END 
GO



