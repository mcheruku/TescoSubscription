/*

	Author:			Manjunathan Raman
	Date created:	01-Oct-2012
	Table Type:		Reference
	Table Size:		
	Purpose:		To store Coupon Attributes
	Usage:			Coupon Details reference
	Fillfactor:		
	Archiving:		

	--Modifications History--
	Changed On		Changed By		Defect Ref		Change Description
	<dd Mmm YYYY>	<Dev Name>		<TFS no.>		<Summary of changes>

*/
IF OBJECT_ID(N'[Coupon].[CouponAttributes]',N'U') IS NULL
	BEGIN

		CREATE TABLE [Coupon].[CouponAttributes](
			[CouponID] BIGINT NOT NULL,
			[AttributeID] [smallint] NOT NULL,
			[AttributeValue] [nvarchar](50) NOT NULL,
			[UTCCreatedDateTime] [smalldatetime] NOT NULL,
			[UTCUpdatedDateTime] [smalldatetime] NOT NULL,
		 CONSTRAINT [PK_CouponAttributes] PRIMARY KEY CLUSTERED 
		(
			[CouponID] ASC,
			[AttributeID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]
		

		ALTER TABLE [Coupon].[CouponAttributes] ADD  CONSTRAINT [DF_CouponAttributes_UTCCreatedDateTime]  DEFAULT (getutcdate()) FOR [UTCCreatedDateTime]

		ALTER TABLE [Coupon].[CouponAttributes] ADD  CONSTRAINT [DF_CouponAttributes_UTCUpdatedDateTime]  DEFAULT (getutcdate()) FOR [UTCUpdatedDateTime]

		IF OBJECT_ID(N'[Coupon].[CouponAttributes]',N'U') IS NOT NULL
			BEGIN
				PRINT 'SUCCESS - Table [Coupon].[CouponAttributes] created.'
			END
		ELSE
			BEGIN
				RAISERROR('FAIL - Table [Coupon].[CouponAttributes] not created.',16,1)
			END
	END
ELSE
	BEGIN
		PRINT 'EXISTS - Table [Coupon].[CouponAttributes] already exists.'
	END
GO
