/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Procedure [tescosubscription].[SubscriptionPlanCreate]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SubscriptionPlanCreate]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanCreate]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanCreate] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanCreate] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[SubscriptionPlanCreate] does not exist.'
	END
GO
