/*

	Author:			Robin
	Date created:	14-Aug-2013
	Purpose:		Rollback Table [tescosubscription].[ConfigurationSettings]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[ConfigurationSettings]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[ConfigurationSettings]

		IF OBJECT_ID(N'[tescosubscription].[ConfigurationSettings]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[ConfigurationSettings] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[ConfigurationSettings] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[ConfigurationSettings] does not exist.'
	END
GO
