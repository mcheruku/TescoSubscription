/*

	Author:			Saritha Kommineni
	Date created:	18-Jan-2012
	Purpose:		Rollback Procedure [tescosubscription].[DeliverySaverNotificationSummary]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverNotificationSummary]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[DeliverySaverNotificationSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverNotificationSummary]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverNotificationSummary] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverNotificationSummary] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[DeliverySaverNotificationSummary] does not exist.'
	END
GO
