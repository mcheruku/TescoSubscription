/*

	Author:			Saritha Kommineni
	Date created:	25-Aug-2011
	Purpose:		Rollback Table [tescosubscription].[PackageExecutionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[PackageExecutionHistory]

		IF OBJECT_ID(N'[tescosubscription].[PackageExecutionHistory]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PackageExecutionHistory] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PackageExecutionHistory] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[PackageExecutionHistory] does not exist.'
	END
GO
