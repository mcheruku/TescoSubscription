/*

	Author:			Rajendra Singh
	Date created:	27-Jul-2011
	Purpose:		Rollback Foreign Key [tescosubscription].[FK_CustomerPayment_PaymentModeMaster_PaymentModeID]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPayment_PaymentModeMaster_PaymentModeID]') 
	 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPayment]'))
	BEGIN

		ALTER TABLE [tescosubscription].[CustomerPayment] DROP CONSTRAINT [FK_CustomerPayment_PaymentModeMaster_PaymentModeID]

		IF NOT EXISTS(SELECT 1 FROM sys.foreign_keys WHERE object_id =OBJECT_ID(N'[tescosubscription].[FK_CustomerPayment_PaymentModeMaster_PaymentModeID]') 
		 AND parent_object_id = OBJECT_ID(N'[tescosubscription].[CustomerPayment]'))
			BEGIN
				PRINT 'SUCCESS - Foreign Key [tescosubscription].[FK_CustomerPayment_PaymentModeMaster_PaymentModeID] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Foreign Key [tescosubscription].[FK_CustomerPayment_PaymentModeMaster_PaymentModeID] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Foreign Key [tescosubscription].[FK_CustomerPayment_PaymentModeMaster_PaymentModeID] does not exist.'
	END
GO
