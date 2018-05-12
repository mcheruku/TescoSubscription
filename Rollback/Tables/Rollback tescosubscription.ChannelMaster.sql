/*

	Author:			Saritha Kommineni
	Date created:	27-Jul-2011
	Purpose:		Rollback Table [tescosubscription].[ChannelMaster]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[ChannelMaster]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[ChannelMaster]

		IF OBJECT_ID(N'[tescosubscription].[ChannelMaster]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[ChannelMaster] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[ChannelMaster] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[ChannelMaster] does not exist.'
	END
GO
