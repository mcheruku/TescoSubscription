/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[ChannelMaster] and [tescosubscription].[CustomerPaymentHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[ChannelMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_ChannelMaster_ChannelID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] FOREIGN KEY([ChannelID])
				REFERENCES [tescosubscription].[ChannelMaster] ([ChannelID])

				ALTER TABLE [tescosubscription].[CustomerPaymentHistory] CHECK CONSTRAINT [FK_CustomerPaymentHistory_ChannelMaster_ChannelID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPaymentHistory_ChannelMaster_ChannelID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPaymentHistory_ChannelMaster_ChannelID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[ChannelMaster]/[tescosubscription].[CustomerPaymentHistory] does not exist.',16,1)
	END
GO
