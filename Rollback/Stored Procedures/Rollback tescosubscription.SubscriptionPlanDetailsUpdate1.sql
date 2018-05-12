/*

	Author:			Saritha Kommineni
	Date created:	23-Aug-2011
	Purpose:		Rollback Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate1]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[SubscriptionPlanDetailsUpdate1]

		IF OBJECT_ID(N'[tescosubscription].[SubscriptionPlanDetailsUpdate1]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[SubscriptionPlanDetailsUpdate1] does not exist.'
	END
GO
