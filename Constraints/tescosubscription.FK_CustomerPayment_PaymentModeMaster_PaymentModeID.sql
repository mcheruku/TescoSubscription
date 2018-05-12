/*

	Author:			Rajendra Pratap Singh
	Date created:	27-Jul-2011
	Purpose:		This constraint maintains relationship between tables [tescosubscription].[PaymentModeMaster] and [tescosubscription].[CustomerPayment]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[PaymentModeMaster]',N'U') IS NOT NULL AND
		OBJECT_ID(N'[tescosubscription].[CustomerPayment]',N'U') IS NOT NULL
	BEGIN
		IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPayment_PaymentModeMaster_PaymentModeID')
			BEGIN

				ALTER TABLE [tescosubscription].[CustomerPayment]  WITH NOCHECK ADD  CONSTRAINT [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] FOREIGN KEY([PaymentModeID])
				REFERENCES [tescosubscription].[PaymentModeMaster] ([PaymentModeID])
				NOT FOR REPLICATION 

				ALTER TABLE [tescosubscription].[CustomerPayment] CHECK CONSTRAINT [FK_CustomerPayment_PaymentModeMaster_PaymentModeID]

				IF EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME = N'FK_CustomerPayment_PaymentModeMaster_PaymentModeID')
					BEGIN
						PRINT 'SUCCESS - Foreign Key [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] added.'
					END
				ELSE
					BEGIN
						RAISERROR('FAIL - Foreign Key [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] not added.',16,1)
					END
			END
		ELSE
			BEGIN
				PRINT 'EXISTS - Foreign Key [FK_CustomerPayment_PaymentModeMaster_PaymentModeID] already exists.'
			END
	END
ELSE
	BEGIN
		RAISERROR('FAIL - Table(s) [tescosubscription].[PaymentModeMaster]/[tescosubscription].[CustomerPayment] does not exist.',16,1)
	END
GO
