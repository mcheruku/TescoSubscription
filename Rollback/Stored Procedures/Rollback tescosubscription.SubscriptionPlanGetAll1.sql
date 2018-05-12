/*

	Author:			Robin
	Date created:	05-Dec-2012
	Purpose:		Rollback Procedure [tescosubscription].[SubscriptionPlanGetAll1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SubscriptionPlanGetAll1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanGetAll1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanGetAll1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanGetAll1] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[SubscriptionPlanGetAll1] does not exist.'
	END
GO
