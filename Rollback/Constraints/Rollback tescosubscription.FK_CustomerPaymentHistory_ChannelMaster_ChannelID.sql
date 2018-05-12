/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerPaymentHistory_ChannelMaster_ChannelID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentHistory_ChannelMaster_ChannelID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerPaymentHistory] DROP CONSTRAINT [FK_CustomerPaymentHistory_ChannelMaster_ChannelID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPaymentHistory_ChannelMaster_ChannelID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerPaymentHistory_ChannelMaster_ChannelID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerPaymentHistory_ChannelMaster_ChannelID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerPaymentHistory_ChannelMaster_ChannelID] does not exist.'
	END
GO
