USE [TescoSubscription]

GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Holds reference data for Coupon Usage Type
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/
IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NULL
	BEGIN
CREATE TABLE [Coupon].[CouponUsageType](
	[UsageTypeID] [tinyint] NOT NULL,
	[UsageName] [nvarchar](80) NOT NULL,
	[UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_CouponUsageType] PRIMARY KEY CLUSTERED 
(
	[UsageTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
    

ALTER TABLE [Coupon].[CouponUsageType] ADD  CONSTRAINT [DF_CouponUsageType_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

ALTER TABLE [Coupon].[CouponUsageType] ADD  CONSTRAINT [DF_CouponUsageType_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]
     BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponUsageType] created.'
	 END


		IF OBJECT_ID(N'[Coupon].[CouponUsageType]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponUsageType] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponUsageType] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CouponUsageType] already exists.'
	END
GO


