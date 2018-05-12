/*

	Author:			Saritha Kommineni
	Date created:	24-Aug-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[StatusMaster] and [tescosubscription].[CustomerSubscription]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[StatusMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerSubscription]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_PaymentProcessStatus')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerSubscription]  WITH CHECK ADD  CONSTRAINT [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] FOREIGN KEY([PaymentProcessStatus])
				REFERENCES [tescosubscription].[StatusMaster] ([StatusId])

				ALTER TABLE [tescosubscription].[CustomerSubscription] CHECK CONSTRAINT [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerSubscription_StatusMaster_PaymentProcessStatus')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerSubscription_StatusMaster_PaymentProcessStatus] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[StatusMaster]/[tescosubscription].[CustomerSubscription] does not exist.',16,1)
	END
GO
