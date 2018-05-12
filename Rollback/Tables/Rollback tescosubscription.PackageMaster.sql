/*

	Author:			Saritha Kommineni
	Date created:	25-Aug-2011
	Purpose:		Rollback Table [tescosubscription].[PackageMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PackageMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[PackageMaster]

		IF OBJECT_ID(N'[tescosubscription].[PackageMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[PackageMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[PackageMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[PackageMaster] does not exist.'
	END
GO
