/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Procedure [tescosubscription].[CustomerSubscriptionUpdate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	12 06/ 2012 	Robin		<TFS no.>		    Added get UTC date in SP

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[CustomerSubscriptionUpdate]

		IF OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionUpdate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[CustomerSubscriptionUpdate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[CustomerSubscriptionUpdate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[CustomerSubscriptionUpdate] does not exist.'
	END
GO
