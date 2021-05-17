import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/webView/web_view_screen.dart';

Widget buildArticleItem (article,context) => InkWell(
  onTap: (){
    navigateTo(context,WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          height: 120.0,

          width: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(12.0),

              image: DecorationImage(

                fit: BoxFit.cover,

                image: article['urlToImage'] != null ? NetworkImage('${article['urlToImage']}')

                    :  NetworkImage('https://pic.onlinewebfonts.com/svg/img_344271.png'),

              ),

          ),

        ),

        SizedBox(width: 10.0,),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                   '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      color: Colors.grey

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list,context,{isSearch=false}) => ConditionalBuilder(
    condition: list.length>0 ,
    builder: (BuildContext context) =>
        ListView.separated(
          itemBuilder:(BuildContext context , int index) => buildArticleItem(list[index],context),
          separatorBuilder: (BuildContext context, int index) =>  myDivider(),
          itemCount: list.length,
          physics: BouncingScrollPhysics(),
        ),
    fallback: (BuildContext context) => isSearch ? Container() : Center(child: CircularProgressIndicator())
);

Widget defaultFormField({
  @required TextEditingController controller,
  TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));