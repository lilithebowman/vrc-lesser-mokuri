Thank you for downloading Lesser Mokuri.
This document is the manual of Lesser Mokuri.
This contains License file as a separate file.

■Change Log■

v2.20　2020.05.03
Fixed the defect of fbx.

v2.10　2020.04.22
Wrap Lesser Mokuri model for the PC version and Quest version to distribute on Virtual Market Beta.

v2.00　2020.01.27
Release Quest version of Lesser Mokuri.

v1.00　2018.08.20
Release PC version of Lesser Mokuri.

■How to Import Avatar■

1. Please download and install VRC SDK in Unity project from the official VRC website before you import the model. 
   Please install Dynamic bones as well if needed.

2. Please import Lesser_Mokuri.unitypackage in the folder.
   The imported avatar will show up in Hierarcy by opening up Scene file from "Open Scene".

3. If you would like to modify Lesser Mokuri, please use the model file and texture file under either "Lesser_Mokuri" or "Quest_Lesser_Mokuri".
   The texture has .png file format and .psd file format (.psd only available for Quest version). The model is fbx file format.


■About Texture■
・For Lesser_Mokuri
　h_body_Base_Color.png　: The texture image file for Body and Ear Material in Skins layer under MeshRoot.
　h_props_BaseColor.png　: The texture image file for Body and Ear Material in Acce and Hairs folder under MeshRoot.

　h_body_Metallic.png
　h_props_Metallic.png
　: Please use them in the shader for metallic expression.

　h_body_Normal.png
　h_props_Normal.png
　: Please use them in the shader for normal expression.

・For Quest_Lesser_Mokuri
　h_body_Base_Color.png　: Texture for Body Material.
　h_props_BaseColor.png　: Texture for Acce Material.

■About Mesh■
・For Lesser_Mokuri
　Meshes in Acce under MeshRoot are: Apron, Armguard, Cylinder, Helmet.
　Meshes in Hairs under MeshRoot are : Hair_Back, Hair_Ear, Hair_Front, Hair_Side_In, Hair_Side_Out.
 Meshes in Skins under MeshRoot are : Body and Ear.

・For Quest_Lesser_Mokuri
　Meshes are Body and Acce.

■About Shapekeys■
・For Lesser_Mokuri
Body has all the settings for shapekeys.

Shapekeys for Lipsync
sil　: Lipsync shapekey for sil
"あ"　Mouth shape for Japanese "a" ※Use for "aa" and "kk"
"い"　Mouth shape for Japanese "i" ※Use for "CH", "SS", and "ih"
"う"　Mouth shape for Japanese "u" ※Use for "FF" and "ou"
"え"　Mouth shape for Japanese "e" ※Use for "DD", "nn", "RR", and "E"
"お"　Mouth shape for Japanese "o"　※Use for "TH" and "oh"
"ん"　Mouth shape for Japanese "nn" ※Use for "PP"

Shapekeys for expression
笑顔目右 : Right Eye Smile
笑顔目左 : Left Eye Smile
目閉じ : Eyes Closed
びっくり : Surprised
眠い : Sleepy
泣きそう : Crying
ニコッ : Smile
キバ : Tooth

・For Quest_Lesser_Mokuri
Body ahs all the settings for shapekeys.

Shapekeys for Lipsync
sil　: Lipsync shapekey for sil
"あ"　Mouth shape for Japanese "a" ※Use for "aa" and "kk"
"い"　Mouth shape for Japanese "i" ※Use for "CH", "SS", and "ih"
"う"　Mouth shape for Japanese "u" ※Use for "FF" and "ou"
"え"　Mouth shape for Japanese "e" ※Use for "DD", "nn", "RR", and "E"
"お"　Mouth shape for Japanese "o"　※Use for "TH" and "oh"
"ん"　Mouth shape for Japanese "nn" ※Use for "PP"

Shapekeys for expression
大あ : Big "あ"
目_笑顔右 : Eye_RightSmile
目_笑顔左 : Eye_LeftSmile
目_びっくり : Eye_Surprised
目_眠い : Eye_Sleepy
目_瞬き右 : Eye_BlinkRight
目_瞬き左 : Eye_BlinkLeft
眉_ビックリ : EyeBrow_Surprised
眉_下 : EyeBrow_Down
眉_上 : EyeBrow_Up
眉_怒り : EyeBrow_Anger
キバ : Tooth
あ2 : "あ"2 (Mouth shape for Japanese "a" 2)

ーーーーーー
【MOKURI project】
Official HP<http://mokuri.world/>
Official Twitter<https://twitter.com/mokuriproject>
HIKKY Inc.<https://www.hikky.life/>

2020/04/22

