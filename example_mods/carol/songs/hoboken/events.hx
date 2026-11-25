function create()
{
	setCameraOffset('dad', 200, 150);
	setCameraOffset('gf', 0, 200);
	setDefaultCamZoom(0.9);

	fish = new FishEyeShader();
	fish.dist.value = [0.03];
	// FlxG.camera.filters = [new ShaderFilter(fish)];
}

function stepHit(curStep)
{
	switch (curStep)
	{
		case 0:
			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 3:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 6:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 10:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 12:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 16:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 19:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 22:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 26:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 28:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 32:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 35:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 38:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 42:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 44:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 48:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 51:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 54:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 58:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 60:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 64:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 5517.241379 | params: [0]

		case 67:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 70:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 74:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 76:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 80:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 83:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 86:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 90:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 92:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 96:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 8275.862069 | params: [1]

		case 99:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 102:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 106:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 108:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 112:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 115:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 118:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 122:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 124:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 126:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 128:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 131:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 134:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 138:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 140:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 144:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 148:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 150:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 154:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 156:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 160:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 13793.103448 | params: [0]

		case 163:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 166:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 170:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 172:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 176:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 179:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 182:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 186:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 188:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 192:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 195:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 198:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 202:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 204:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 208:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 212:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 214:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 218:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 220:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 18965.517241 | params: [1]

		case 224:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 227:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 230:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 234:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 236:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 240:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 243:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 246:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 250:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 256:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 260:
			// Camera Movement | time: 22413.793103 | params: [0]

		case 264:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 272:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 284:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 288:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 296:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 304:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 316:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 320:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 324:
			// Camera Movement | time: 27931.034483 | params: [1]

		case 328:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 336:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 348:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 352:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 360:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 368:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 380:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 384:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 33103.448276 | params: [0]

		case 392:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 400:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 412:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 416:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 424:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 432:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 444:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 448:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 38620.689655 | params: [1]

		case 456:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 464:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 476:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 480:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 488:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 496:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 508:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 512:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 44137.931034 | params: [2]

		case 518:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 524:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 532:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 540:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 544:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 556:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 564:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 570:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 572:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 576:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 584:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 592:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 602:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 604:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 608:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 615:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 623:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 628:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 632:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 636:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 640:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 646:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 652:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 660:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 668:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 672:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 684:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 692:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 698:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 700:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 704:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 712:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 720:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 730:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 732:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 736:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 743:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 751:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 756:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 760:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 764:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
			camZoomInterval(1, 0.018, 0.036);

		case 896:
			// Camera Modulo Change | time: 77241.37931 | params: [1,1.2]

			camZoomInterval(1, 0.018, 0.036);
		// Camera Movement | time: 77241.37931 | params: [1]

		case 1024:
			// Camera Modulo Change | time: 88275.862069 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 88275.862069 | params: [0]

		case 1027:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1030:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1034:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1036:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1040:
			// Camera Modulo Change | time: 89655.172414 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1043:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1046:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1050:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1052:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1056:
			// Camera Modulo Change | time: 91034.482759 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1059:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1062:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1066:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1068:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1072:
			// Camera Modulo Change | time: 92413.793103 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1075:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1078:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1082:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1084:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1088:
			// Camera Modulo Change | time: 93793.103448 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1091:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1094:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1098:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1100:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1104:
			// Camera Modulo Change | time: 95172.413793 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1107:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1110:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1114:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1116:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1120:
			// Camera Modulo Change | time: 96551.724138 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1123:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1126:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1130:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1132:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1136:
			// Camera Modulo Change | time: 97931.034483 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1139:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1142:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1146:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1148:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1150:
			// Camera Modulo Change | time: 99137.931034 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1152:
			// Camera Modulo Change | time: 99310.344828 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 99310.344828 | params: [1]

		case 1155:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1158:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1162:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1164:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1168:
			// Camera Modulo Change | time: 100689.655172 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1171:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1174:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1178:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1180:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1184:
			// Camera Modulo Change | time: 102068.965517 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1187:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1190:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1194:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1196:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1200:
			// Camera Modulo Change | time: 103448.275862 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1203:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1206:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1210:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1212:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1216:
			// Camera Modulo Change | time: 104827.586207 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1219:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1222:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1226:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1228:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1232:
			// Camera Modulo Change | time: 106206.896552 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1235:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1238:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1242:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1244:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1248:
			// Camera Modulo Change | time: 107586.206897 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1251:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1254:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1258:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1260:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1264:
			// Camera Modulo Change | time: 108965.517241 | params: [888,1]

			camZoomInterval(888, 0.015, 0.03);
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1267:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1270:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1274:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1276:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1278:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1280:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;
		// Camera Movement | time: 110344.827586 | params: [0]

		case 1284:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1288:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1291:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1294:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1296:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1300:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1304:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1307:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1310:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1312:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1316:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1320:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1323:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1326:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1328:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1332:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1336:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1339:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1342:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1344:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1348:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1352:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1355:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1358:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1360:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1364:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1368:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1371:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1374:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1376:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1380:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1384:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1387:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1390:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1392:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1396:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1400:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1403:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1406:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1408:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;
		// Camera Movement | time: 121379.310345 | params: [1]

		case 1412:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1416:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1419:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1422:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1424:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1428:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1432:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1435:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1438:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1440:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1444:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1448:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1451:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1454:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1456:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1460:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1464:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1467:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1470:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1472:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1476:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1480:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1483:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1486:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1488:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1492:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1496:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1499:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1502:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1504:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1508:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1512:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1515:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1518:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1520:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1524:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1528:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1531:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1534:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;

		case 1536:
			camGame.zoom += 0.02;
			camHUD.zoom += 0.06;
			// Camera Modulo Change | time: 132413.793103 | params: [4,1]

			camZoomInterval(4, 0.015, 0.03);

		case 1540:
			// Camera Movement | time: 132758.62069 | params: [0]

		case 1596:
			// Camera Movement | time: 137586.206897 | params: [1]

		case 1628:
			// Camera Movement | time: 140344.827586 | params: [0]

		case 1660:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1664:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;
		// Camera Movement | time: 143448.275862 | params: [2]

		case 1670:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1676:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1684:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1692:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1696:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1708:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1716:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1722:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1724:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1728:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1736:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1744:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1754:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1756:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1760:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1767:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1775:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1780:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1784:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1788:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1792:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1798:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1804:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1812:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1820:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1824:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1836:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1844:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1850:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1852:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1856:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1864:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1872:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1882:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1884:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1888:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1895:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1903:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1908:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1912:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1916:
			camGame.zoom += 0.01;
			camHUD.zoom += 0.03;

		case 1920:
			// Camera Modulo Change | time: 165517.241379 | params: [1,1]

			camZoomInterval(1, 0.015, 0.03);
		// Camera Movement | time: 165517.241379 | params: [0]

		case 2032:
			camZoomInterval(2, 0.015, 0.03, "step");

		case 2040:
			// Camera Modulo Change | time: 175862.068966 | params: [1,0.9]

			camZoomInterval(1, 0.0135, 0.027, "step");

		case 2048:
			// Camera Modulo Change | time: 176551.724138 | params: [1,1.2]

			camZoomInterval(1, 0.018, 0.036);
		// Camera Movement | time: 176551.724138 | params: [1]

		case 2160:
			// Camera Modulo Change | time: 186206.896552 | params: [4,1]

			camZoomInterval(4, 0.015, 0.03);
	}
}
