USE [TescoSubscription]
GO

/*

	Author:			Robin
	Date created:	14-Jan-2014
	Table Type:		Reference
	Table Size:		Estimated < 100 rows
	Purpose:		Holds reference data for Campaign discount Type
	Archiving:		<Archiving requirements>

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>
	

*/
IF OBJECT_ID(N'[Coupon].[DiscountTypeMaster]',N'U') IS NULL
	BEGIN
CREATE TABLE [Coupon].[DiscountTypeMaster](
	[DiscountTypeId] [tinyint] NOT NULL,
	[DiscountName] [nvarchar](80) NOT NULL,
    [UTCCreatedDateTime] [datetime] NOT NULL,
	[UTCUpdatedDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_CouponDiscountType] PRIMARY KEY CLUSTERED 
(
	[DiscountTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Coupon].[DiscountTypeMaster] ADD  CONSTRAINT [DF_DiscountTypeMaster_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

ALTER TABLE [Coupon].[DiscountTypeMaster] ADD  CONSTRAINT [DF_DiscountTypeMaster_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

BEGIN
				PRINT 'SUCCESS - Table [Coupon].[DiscountTypeMaster] created.'
	 END


		IF OBJECT_ID(N'[Coupon].[DiscountTypeMaster]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[DiscountTypeMaster] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[DiscountTypeMaster] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[DiscountTypeMaster] already exists.'
	END
GO


