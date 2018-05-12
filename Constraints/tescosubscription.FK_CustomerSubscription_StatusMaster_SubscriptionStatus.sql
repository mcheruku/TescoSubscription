/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_SubscriptionStatus')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] FOREIGN KEY([SubscriptionStatus])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusId])

				ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_StatusMaster_SubscriptionStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_SubscriptionStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_StatusMaster_SubscriptionStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO
