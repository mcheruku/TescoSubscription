/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[StatusMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[StatusMaster]

		IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[StatusMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[StatusMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[StatusMaster] does not exist.'
	END
GO
