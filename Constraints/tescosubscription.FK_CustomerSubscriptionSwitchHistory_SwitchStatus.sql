/*

	Author:			Robin John
	Date created:	07-Jan-2012
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscriptionSwitchHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionSwitchHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchStatus')
			BEGIN
ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] FOREIGN KEY(SwitchStatus)
REFERENCES [tescosubscription].[StatusMaster] (StatusId)

ALTER TABLE [tescosubscription].[CustomerSubscriptionSwitchHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionSwitchHistory_SwitchStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionSwitchHistory_SwitchStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionSwitchHistory_SwitchStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscriptionSwitchHistory] does not exist.',16,1)
	END
GO

GO