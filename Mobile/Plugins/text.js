function replaceSpecials(thestring) {

    var spchar = ['\! ;#x21;','\" ;#x22;',"\' ;#x27;",'\, ;#x2c;','\& ;#x26;','\\( ;#x28;', '\\) ;#x29;','\\{ ;#x7b;','\\} ;#x7d;']
    var num = 0

    //    console.log("spchar list length "+spchar.length+"\n");
    while (spchar.length - 1 >= num) {
        // console.log("Finding all "+spchar[num].split(" ")[0]+"s");
        var findall = new RegExp(spchar[num].split(" ")[0], "g")
        thestring = thestring.replace(findall, spchar[num].split(" ")[1])

        num = num + 1
    }

    //console.log(thestring);
    return thestring
}

function recoverSpecial(thestring) {

    var spchar = ['\! ;#x21;','\" ;#x22;',"\' ;#x27;",'\, ;#x2c;','\& ;#x26;','( ;#x28;',') ;#x29;','{ ;#x7b;','} ;#x7d;']
    var num = 0

    while (spchar.length - 1 >= num) {
        //  console.log("Finding all"+spchar[num].split(" ")[1]+"s");

        var findall = new RegExp(spchar[num].split(" ")[1], "g")
        thestring = thestring.replace(findall, spchar[num].split(" ")[0])
        //console.log(thestring);
        num = num + 1
    }

    return thestring
}
/* Key code reference just encase we need to add others */
/*
!	;#33;	;#x21;
"	;#34;	;#x22;	&quot;
#	;#35;	;#x23;
$	;#36;	;#x24;
%	;#37;	;#x25;
&	;#38;	;#x26;	&amp;
'	;#39;	;#x27;
(	;#40;	;#x28;
)	;#41;	;#x29;
*	;#42;	;#x2a;
+	;#43;	;#x2b;
,	;#44;	;#x2c;
-	;#45;	;#x2d;
.	;#46;	;#x2e;
/	;#47;	;#x2f;
:	;#58;	;#x3a;
;	;#59;	;#x3b;
<	;#60;	;#x3c;	&lt;
=	;#61;	;#x3d;
>	;#62;	;#x3e;	&gt;
?	;#63;	;#x3f;
@	;#64;	;#x40;
[	;#91;	;#x5b;
\	;#92;	;#x5c;
]	;#93;	;#x5d;
^	;#94;	;#x5e;
_	;#95;	;#x5f;
`	;#96;	;#x60;
{	;#123;	;#x7b;
|	;#124;	;#x7c;
}	;#125;	;#x7d;
~	;#126;	;#x7e;
    ;#160;	;#xa0;	&nbsp;
¡	;#161;	;#xa1;	&iexl;
¢	;#162;	;#xa2;	&cent;
£	;#163;	;#xa3;	&pound;
¤	;#164;	;#xa4;	&curren;
¥	;#165;	;#xa5;	&yen;
¦	;#166;	;#xa6;	&brvbar;
§	;#167;	;#xa7;	&sect;
¨	;#168;	;#xa8;	&uml;
©	;#169;	;#xa9;	&copy;
ª	;#170;	;#xaa;	&ordf;
«	;#171;	;#xab;	&laquo;
¬	;#172;	;#xac;	&not;
­	;#173;	;#xad;	&shy;
®	;#174;	;#xae;	&reg;
¯	;#175;	;#xaf;	&macr;
°	;#176;	;#xb0;	&deg;
±	;#177;	;#xb1;	&plusmn;
²	;#178;	;#xb2;	&sup2;
³	;#179;	;#xb3;	&sup3;
´	;#180;	;#xb4;	&acute;
µ	;#181;	;#xb5;	&micro;
¶	;#182;	;#xb6;	&para;
·	;#183;	;#xb7;	&middot;
¸	;#184;	;#xb8;	&cedil;
¹	;#185;	;#xb9;	&sup1;
º	;#186;	;#xba;	&ordm;
»	;#187;	;#xbb;	&raquo;
¼	;#188;	;#xbc;	&frac14;
½	;#189;	;#xbd;	&frac12;
¾	;#190;	;#xbe;	&frac34;
¿	;#191;	;#xbf;	&iquest;
À	;#192;	;#xc0;	&Agrave;
Á	;#193;	;#xc1;	&Aacute;
Â	;#194;	;#xc2;	&Acirc;
Ã	;#195;	;#xc3;	&Atilde;
Ä	;#196;	;#xc4;	&Auml;
Å	;#197;	;#xc5;	&Aring;
Æ	;#198;	;#xc6;	&AElig;
Ç	;#199;	;#xc7;	&Ccedil;
È	;#200;	;#xc8;	&Egrave;
É	;#201;	;#xc9;	&Eacute;
Ê	;#202;	;#xca;	&Ecirc;
Ë	;#203;	;#xcb;	&Euml;
Ì	;#204;	;#xcc;	&Igrave;
Í	;#205;	;#xcd;	&Iacute;
Î	;#206;	;#xce;	&Icirc;
Ï	;#207;	;#xcf;	&Iuml;
Ð	;#208;	;#xd0;	&ETH;
Ñ	;#209;	;#xd1;	&Ntilde;
Ò	;#210;	;#xd2;	&Ograve;
Ó	;#211;	;#xd3;	&Oacute;
Ô	;#212;	;#xd4;	&Ocirc;
Õ	;#213;	;#xd5;	&Otilde;
Ö	;#214;	;#xd6;	&Ouml;
×	;#215;	;#xd7;	&times;
Ø	;#216;	;#xd8;	&Oslash;
Ù	;#217;	;#xd9;	&Ugrave;
Ú	;#218;	;#xda;	&Uacute;
Û	;#219;	;#xdb;	&Ucirc;
Ü	;#220;	;#xdc;	&Uuml;
Ý	;#221;	;#xdd;	&Yacute;
Þ	;#222;	;#xde;	&THORN;
ß	;#223;	;#xdf;	&szlig;
à	;#224;	;#xe0;	&agrave;
á	;#225;	;#xe1;	&aacute;
â	;#226;	;#xe2;	&acirc;
ã	;#227;	;#xe3;	&atilde;
ä	;#228;	;#xe4;	&auml;
å	;#229;	;#xe5;	&aring;
æ	;#230;	;#xe6;	&aelig;
ç	;#231;	;#xe7;	&ccedil;
è	;#232;	;#xe8;	&egrave;
é	;#233;	;#xe9;	&eacute;
ê	;#234;	;#xea;	&ecirc;
ë	;#235;	;#xeb;	&euml;
ì	;#236;	;#xec;	&igrave;
í	;#237;	;#xed;	&iacute;
î	;#238;	;#xee;	&icirc;
ï	;#239;	;#xef;	&iuml;
ð	;#240;	;#xf0;	&eth;
ñ	;#241;	;#xf1;	&ntilde;
ò	;#242;	;#xf2;	&ograve;
ó	;#243;	;#xf3;	&oacute;
ô	;#244;	;#xf4;	&ocirc;
õ	;#245;	;#xf5;	&otilde;
ö	;#246;	;#xf6;	&ouml;
÷	;#247;	;#xf7;	&divide;
ø	;#248;	;#xf8;	&oslash;
ù	;#249;	;#xf9;	&ugrave;
ú	;#250;	;#xfa;	&uacute;
û	;#251;	;#xfb;	&ucirc;
ü	;#252;	;#xfc;	&uuml;
ý	;#253;	;#xfd;	&yacute;
þ	;#254;	;#xfe;	&thorn;
ÿ	;#255;	;#xff;	&yuml;
*/

