/*

	Author:			Saritha Kommineni
	Date created:	25-Aug-2011
	Purpose:		Rollback Table [tescosubscription].[PackageErrorLog]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageErrorLog]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[PackageErrorLog]

		IF OBJECT_ID(N'[tescosubscription].[PackageErrorLog]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PackageErrorLog] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PackageErrorLog] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[PackageErrorLog] does not exist.'
	END
GO
