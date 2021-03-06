/*

	Author:			Saritha K
	Date created:	06-Jan-2012
	Table Type:		Transactional
	Table Size:		
	
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of change
*/

IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NULL
	BEGIN
CREATE TABLE [tescosubscription].[CustomerPaymentHistoryResponse](
	[CustomerPaymentHistoryResponseID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerPaymentHistoryID] [bigint] NOT NULL,
	[PaymentStatusID] [tinyint] NOT NULL,
	[Remarks] [varchar](100) NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL CONSTRAINT [DF_CustomerPaymentHistoryResponse_UTCCreatedDateTime]  DEFAULT (getutcdate()),
 CONSTRAINT [PK_CustomerPaymentHistoryResponse] PRIMARY KEY CLUSTERED 
(
	[CustomerPaymentHistoryResponseID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF OBJECT_ID(N'[tescosubscription].[CustomerPaymentHistoryResponse]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [tescosubscription].[CustomerPaymentHistoryResponse] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [tescosubscription].[CustomerPaymentHistoryResponse] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [tescosubscription].[CustomerPaymentHistoryResponse] already exists.'
	END
GO

