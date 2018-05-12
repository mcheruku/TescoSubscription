/*

	Author:			Saritha Kommineni
	Date created:	18-Jan-2012
	Purpose:		Rollback Procedure [tescosubscription].[DeliverySaverPackageSummary] 
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NOT NULL
	BEGIN

		DROP PROCEDURE [tescosubscription].[DeliverySaverPackageSummary]

		IF OBJECT_ID(N'[tescosubscription].[DeliverySaverPackageSummary]',N'P') IS NULL
			BEGIN
				PRINT 'SUCCESS - Procedure [tescosubscription].[DeliverySaverPackageSummary] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Procedure [tescosubscription].[DeliverySaverPackageSummary] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Procedure [tescosubscription].[DeliverySaverPackageSummary] does not exist.'
	END
GO
