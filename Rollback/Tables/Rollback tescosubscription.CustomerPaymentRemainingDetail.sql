USE TescoSubscription
GO

/*

	Author:			Robin
	Date created:	20-April-2014
	Purpose:		Rollback Table [tescosubscription].[CustomerPaymentRemainingDetail]

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentRemainingDetail]',N'U') IS NOT NULL
	BEGIN

		DROP TABLE [tescosubscription].[CustomerPaymentRemainingDetail]

		IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentRemainingDetail]',N'U') IS NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerPaymentRemainingDetail] dropped.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerPaymentRemainingDetail] not dropped.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'NOT EXISTS - Table [tescosubscription].[CustomerPaymentRemainingDetail] does not exist.'
	END
GO
