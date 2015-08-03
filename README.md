# AudioManeger
 简单实用播放器
- (void)audioMangaer:(AudioManager *)manager PlayIsEnd:(AVPlayer *)player
{

   NSLog(@"end")
   
}
- (void)audioManager:(AudioManager *)manager BeginToPlayToProgress:(float)progress currentTime:(int)currentTime durationTime:(int)durationTime
{
    
      _valueSilider.value = progress;
      
}
- (void)audioMangaer:(AudioManager *)manager PlayIsGoOn:(AVPlayer *)player
{

    NSLog(@"goon");
    
}
- (void)audioMangaer:(AudioManager *)manager PlayIsPause:(AVPlayer *)player
{

    NSLog(@"pause");
    
}
