USE [TescoSubscription]
GO
/*
Author : Robin
Created Date : 26th August 2014
Purpose : take back up of the records before running the data fix.
*/

CREATE TABLE [Utilities].[dbo].[TescoSubscriptionCustomerPaymentRJ14032014] (
	[CustomerPaymentID] [bigint] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[PaymentModeID] [tinyint] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsFirstPaymentDue] [bit] NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL ,
	[UTCUpdatedDateTime] [datetime] NOT NULL ,
 CONSTRAINT [PK_CustomerPaymentbackup] PRIMARY KEY CLUSTERED 
(
	[CustomerPaymentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO [Utilities].[dbo].[TescoSubscriptionCustomerPaymentRJ14032014]-- backup table for rollback
         ([CustomerPaymentID]  
	     ,[CustomerID] 
	     ,[PaymentModeID] 
	     ,[IsActive]
         ,[IsFirstPaymentDue]
         ,[UTCCreatedDateTime]
         ,[UTCUpdatedDateTime])
         (SELECT[CustomerPaymentID]  
	     ,[CustomerID] 
	     ,[PaymentModeID] 
	     ,[IsActive]
         ,[IsFirstPaymentDue]
         ,[UTCCreatedDateTime]
         ,[UTCUpdatedDateTime]
          FROM Tescosubscription.Tescosubscription.CustomerPayment WITH (NOLOCK)
          WHERE PaymentModeID = 2
	      AND IsActive = 0
	      AND UTCCreatedDateTime = UTCUpdatedDateTime)

PRINT  'Inserted ' + CONVERT(varchar(10), @@Rowcount) + ' records into backup table'
            
 
  