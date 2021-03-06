/*

	Author:			Saritha Kommineni
	Date created:	22-Aug-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscriptionHistory]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscriptionHistory]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] FOREIGN KEY([SubscriptionStatus])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusID])

				ALTER TABLE [tescosubscription].[CustomerSubscriptionHistory] CHECK CONSTRAINT [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscriptionHistory_StatusMaster_SubscriptionStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscriptionHistory] does not exist.',16,1)
	END
GO
