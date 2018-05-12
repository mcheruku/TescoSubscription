/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[BusinessMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[BusinessMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[BusinessMaster]

		IF OBJECT_ID(N'[tescosubscription].[BusinessMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[BusinessMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[BusinessMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[BusinessMaster] does not exist.'
	END
GO
