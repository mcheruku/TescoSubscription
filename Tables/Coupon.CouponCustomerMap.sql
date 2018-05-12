USE [TescoSubscription]
GO

/*******************************************************************************************  
********************************************************************************************  
** TYPE           : CREATE TABLE  
** NAME           : TABLE [Coupon].[CouponCustomerMap] 
** AUTHOR         : INFOSYS TECHNOLOGIES LIMITED  
** DESCRIPTION    : THIS SCRIPT WILL CREATE TABLE [Coupon].[CouponCustomerMap]
** DATE WRITTEN   : 06/03/2013                     
** ARGUMENT(S)    : NONE
** RETURN VALUE(S): NONE
*******************************************************************************************  
*******************************************************************************************/
/*
	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'[Coupon].[CouponCustomerMap]',N'U') IS NULL
	BEGIN


	CREATE TABLE [Coupon].[CouponCustomerMap](
		[CouponID] [BIGINT] NOT NULL,
		[CustomerID] [BIGINT] NOT NULL,
		[UTCCreatedDateTime] [SMALLDATETIME] NOT NULL,
		[UTCUpdatedDateTime] [SMALLDATETIME] NOT NULL
	 CONSTRAINT [PK_CouponCustomerMap] PRIMARY KEY CLUSTERED 
	(
		[CouponID] ASC,
		[CustomerID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [Coupon].[CouponCustomerMap] ADD  CONSTRAINT [DF_CouponCustomerMap_UTCCreatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCCreatedDateTime]

	ALTER TABLE [Coupon].[CouponCustomerMap] ADD  CONSTRAINT [DF_CouponCustomerMap_UTCUpdatedDateTime]  DEFAULT (GETUTCDATE()) FOR [UTCUpdatedDateTime]


	IF OBJECT_ID(N'[Coupon].[CouponCustomerMap]',N'U') IS NOT NULL
				BEGIN
					PRINT 'SUCCESS - Table [Coupon].[CouponCustomerMap] created.'
				END
			ELSE
				BEGIN
					RAISERROR('FAIL - Table [Coupon].[CouponCustomerMap] not created.',16,1)
				END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CouponCustomerMap] already exists.'
	END
GO

