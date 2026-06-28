import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minum_cekk_app/core/app_colors.dart';
import 'package:minum_cekk_app/core/app_text_styles.dart';
import 'package:minum_cekk_app/widgets/status_label_button.dart';



class _GradeData {
  final String title;
  final Color color;
  final String aturanWho;
  final String kategoriText;
  final List<Widget> adultIcons;
  final List<Widget> childIcons;
  final String adultBulletBold;
  final String adultBulletNormal;
  final String childBulletBold;
  final String childBulletNormal;



  const _GradeData({
    required this.title,
    required this.color,
    required this.aturanWho,
    required this.kategoriText,
    required this.adultIcons,
    required this.childIcons,
    required this.adultBulletBold,
    required this.adultBulletNormal,
    required this.childBulletBold,
    required this.childBulletNormal,
  });

}



class LabelDetailScreen extends StatelessWidget {
  const LabelDetailScreen({super.key, required this.healthGrade});



  final String healthGrade;



  _GradeData _getGradeData(String grade, AppColorsExtension colors) {

    Widget buildBottle(String label) {

      return Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          SvgPicture.asset('assets/icons/ic_sugar_bottle.svg', width: 24),

          const SizedBox(height: 8),

          Text(label, style: AppTextStyles.readingText.copyWith(fontSize: 11, color: colors.textPrimary)),

        ],

      );

    }



    Widget buildPerson(String label, String iconName) {

      return Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          SvgPicture.asset('assets/icons/$iconName', height: 48),

          const SizedBox(height: 8),

          Text(label, style: AppTextStyles.readingText.copyWith(fontSize: 11, color: colors.textPrimary)),

        ],

      );

    }



    Widget buildOp(String symbol, String label) {

      return Column(

        mainAxisSize: MainAxisSize.min,

        children: [

          Text(symbol, style: AppTextStyles.secondTitle.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: colors.textPrimary)),

          const SizedBox(height: 4),

          Text(label, style: AppTextStyles.beverageDetail.copyWith(fontSize: 9, color: colors.textPrimary.withOpacity(0.5))),

        ],

      );

    }



    switch (grade) {

      case 'Waspada':

        return _GradeData(

          title: grade,

          color: colors.btnDanger,

          aturanWho: 'Kami menerapkan label WASPADA karena satu botol minuman ini sudah melebihi batas optimal asupan Gula Bebas yang dianjurkan WHO atau Badan Kesehatan Dunia untuk seluruh hari Anda. Konsumsi rutin dapat meningkatkan risiko penyakit kronis.',

          kategoriText: '(dengan gula > 25 gram) berarti satu botol sudah menghabiskan dan bahkan melebihi jatah gula optimal harian Anda.',

          adultIcons: [

            buildBottle('25g Gula'),

            buildOp('> ', 'Lebih dari  '),

            buildPerson('Dewasa', 'ic_adult.svg'),

          ],

          childIcons: [

            buildBottle('20g Gula'),

            buildOp('>', 'Lebih dari'),

            buildPerson('Anak-anak', 'ic_children.svg'),

          ],

          adultBulletBold: 'Dewasa (18 Tahun ke Atas)',

          adultBulletNormal: ' : Melebihi batas optimal 25 gram Gula dalam sehari.',

          childBulletBold: 'Anak-anak (2 - 18 Tahun)',

          childBulletNormal: ' : Minuman yang berada di atas 20 gram Gula dalam sehari, sudah melebihi batas optimal harian anak.',

        );



      case 'Hati-Hati':

        return _GradeData(

          title: grade,

          color: colors.btnWarning,

          aturanWho: 'Kami menerapkan label Hati-Hati karena satu botol minuman ini sudah hampir mendekati batas optimal asupan Gula Bebas yang dianjurkan WHO atau Badan Kesehatan Dunia untuk seluruh hari Anda. Jangan terlalu sering untuk di konsumsi agar anda berada di batas aman.',

          kategoriText: '(dengan 8 gram < Gula \u2264 25 gram) berarti satu botol sudah menghabiskan seluruh jatah Gula optimal Anda dalam sehari.',

          adultIcons: [

            buildBottle('8g Gula'),

            buildOp('~ ', 'antara '),

            buildBottle('25g Gula'),

            buildPerson('Dewasa', 'ic_adult.svg'),

          ],

          childIcons: [

            buildBottle('8g Gula'),

            buildOp('~', 'antara'),

            buildBottle('20g Gula'),

            buildPerson('Anak-anak', 'ic_children.svg'),

          ],

          adultBulletBold: 'Dewasa (18 Tahun ke Atas)',

          adultBulletNormal: ' : Minuman ini menghabiskan 80-100% jatah gula optimal Anda. Konsumsi hari ini, TIDAK ADA minuman manis lainnya!',

          childBulletBold: 'Anak-anak (2 - 18 Tahun)',

          childBulletNormal: ' : Minuman yang berada di atas 20 gram Gula dalam sehari, sudah melebihi batas optimal harian anak. Disarankan HANYA SETENGAH porsi dan hindari semua gula tambahan lain hari ini!',

        );



      case 'Aman':

        return _GradeData(

          title: grade,

          color: colors.btnSafe,

          aturanWho: 'Kami menerapkan label Aman karena satu botol minuman ini jauh dari melebihi batas optimal asupan Gula Bebas yang dianjurkan WHO atau Badan Kesehatan Dunia untuk seluruh hari Anda. Konsumsi 1-2 sajian per hari masih aman untuk menjaga diri Anda tetap sehat.',

          kategoriText: '(dengan 1 gram < Gula \u2264 8 gram) Konsumsi maksimal 1 - 2 sajian per hari masih memungkinkan Anda menjaga asupan gula total tetap rendah.',

          adultIcons: [

            buildBottle('1g Gula'),

            buildOp('~ ', 'antara '),

            buildBottle('8g Gula'),

            buildPerson('Dewasa', 'ic_adult.svg'),

          ],

          childIcons: [

            buildBottle('1g Gula'),

            buildOp('~', 'antara'),

            buildBottle('8g Gula'),

            buildPerson('Anak-anak', 'ic_children.svg'),

          ],

          adultBulletBold: 'Dewasa (18 Tahun ke Atas)',

          adultBulletNormal: ' : Satu sajian (Maksimal 8 gram) hanya menyumbang sekitar 32% dari batas optimal harian. Konsumsi 2-3 sajian masih aman.',

          childBulletBold: 'Anak-anak (2 - 18 Tahun)',

          childBulletNormal: ' : Minuman yang berada di atas 20 gram Gula dalam sehari, sudah melebihi batas optimal harian anak.',

        );



      case 'Sangat Aman':

      default:

        return _GradeData(

          title: grade,

          color: colors.btnVerySafe,

          aturanWho: 'Kami menerapkan label Sangat Aman karena satu botol minuman ini sangat jauh atau bahkan tidak mungkin dari melebihi batas optimal asupan Gula Bebas yang dianjurkan WHO atau Badan Kesehatan Dunia untuk seluruh hari Anda. Konsumsi Bebas asalkan masih dalam batas wajar.',

          kategoriText: '(dengan \u2264 1 gram) Minuman yang secara alami tidak mengandung gula tambahan dan gula alaminya sangat rendah.',

          adultIcons: [

            buildBottle('1g Gula'),

            buildOp('\u2264 ', 'Kurang sama dengan   '),

            buildPerson('Dewasa', 'ic_adult.svg'),

          ],

          childIcons: [

            buildBottle('1g Gula'),

            buildOp('\u2264', 'Kurang sama dengan'),

            buildPerson('Anak-Anak', 'ic_children.svg'),

          ],

          adultBulletBold: 'Dewasa (18 Tahun ke Atas)',

          adultBulletNormal: ' : Tidak Menyumbang secara signifikan pada batas optimal. Minuman ini dianggap sebagai pengganti air.',

          childBulletBold: 'Anak-anak (2 - 18 Tahun)',

          childBulletNormal: ' : Pilihan Utama dan Terbaik. Risiko karies gigi dan obesitas sangat rendah.',

        );

    }

  }



  TableRow _buildTableRow(List<String> cells, {bool isHeader = false, required AppColorsExtension colors}) {

    final bgColor = isHeader ? const Color(0xFFD0D0D0) : const Color(0xFFE0E0E0);

    final textStyle = isHeader

        ? AppTextStyles.secondTitle.copyWith(fontSize: 10, color: colors.textPrimary)

        : AppTextStyles.readingText.copyWith(fontSize: 10, color: colors.textPrimary);



    return TableRow(

      decoration: BoxDecoration(color: bgColor),

      children: cells.map((text) {

        return Padding(

          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),

          child: Text(

            text,

            style: textStyle,

            textAlign: TextAlign.center,

          ),

        );

      }).toList(),

    );

  }



  Widget _buildBulletPoint(String boldText, String normalText, AppColorsExtension colors) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(

          '\u25CF   ', // Bullet

          style: AppTextStyles.readingText.copyWith(color: colors.textPrimary),

        ),

        Expanded(

          child: RichText(

            textAlign: TextAlign.justify,

            text: TextSpan(

              style: AppTextStyles.readingText.copyWith(color: colors.textPrimary),

              children: [

                TextSpan(

                  text: boldText,

                  style: const TextStyle(fontWeight: FontWeight.bold),

                ),

                TextSpan(text: normalText),

              ],

            ),

          ),

        ),

      ],

    );

  }



  @override

  Widget build(BuildContext context) {

    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    final data = _getGradeData(healthGrade, colors);



    return Scaffold(

      backgroundColor: colors.fillCanvas,

      body: SafeArea(

        child: Column(

          children: [

            // ── Custom AppBar ──

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),

              child: Row(

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    behavior: HitTestBehavior.opaque,

                    child: SvgPicture.asset(

                      'assets/icons/ic_back.svg',

                      width: 32,

                    ),

                  ),

                  const SizedBox(width: 16),

                  Text(

                    'Penting',

                    style: AppTextStyles.pageTitle.copyWith(

                      color: colors.textPrimary,

                    ),

                  ),

                ],

              ),

            ),



            // ── Main Content (The White Card) ──

            Expanded(

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 16.0),

                child: Container(

                  width: double.infinity,

                  decoration: BoxDecoration(

                    color: colors.background,

                    borderRadius: BorderRadius.circular(24),

                    boxShadow: const [

                      BoxShadow(

                        color: Color(0x40000000), // rgba(0, 0, 0, 0.25)

                        offset: Offset(0, 4),

                        blurRadius: 4,

                      ),

                    ],

                  ),

                  child: SingleChildScrollView(

                    padding: const EdgeInsets.all(24.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,

                      children: [

                        // Label Header Button inside card

                        Center(

                          child: StatusLabelButton(

                            text: data.title,

                            backgroundColor: data.color,

                          ),

                        ),

                        const SizedBox(height: 24),

                        const Divider(color: Color(0xFFD9D9D9), thickness: 3),

                        const SizedBox(height: 16),



                        // Aturan WHO Section

                        Text(

                          'Aturan WHO',

                          style: AppTextStyles.secondTitle.copyWith(

                            color: colors.textPrimary,

                          ),

                        ),

                        const SizedBox(height: 8),

                        Text(

                          data.aturanWho,

                          style: AppTextStyles.readingText.copyWith(

                            color: colors.textPrimary,

                          ),

                          textAlign: TextAlign.justify,

                        ),

                        const SizedBox(height: 24),



                        // Table Section

                        Container(

                          clipBehavior: Clip.hardEdge,

                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(12),

                          ),

                          child: Table(

                            border: TableBorder(

                              horizontalInside: BorderSide(color: colors.background, width: 2),

                              verticalInside: BorderSide(color: colors.background, width: 2),

                            ),

                            columnWidths: const {

                              0: FlexColumnWidth(1.2),

                              1: FlexColumnWidth(1.0),

                              2: FlexColumnWidth(1.0),

                            },

                            children: [

                              _buildTableRow(['Batasan WHO', 'Gula Bebas Harian', 'Setara Sendok TeH SDT)'], isHeader: true, colors: colors),

                              _buildTableRow(['Batas Maksimal\n(Kurang dari 10% Energi)', '\u2264 50 gram', '\u2264 10 SDT'], colors: colors),

                              _buildTableRow(['Batas Optimal\n(Kurang dari 5% Energi)', '\u2264 25 gram', '\u2264 5 SDT'], colors: colors),

                            ],

                          ),

                        ),

                        const SizedBox(height: 32),



                        // Minuman Kategori Header

                        Row(

                          children: [

                            Text(

                              'Minuman kategori ',

                              style: AppTextStyles.secondTitle.copyWith(color: colors.textPrimary),

                            ),

                            SizedBox(

                              width: 80,

                              height: 24,

                              child: FittedBox(

                                fit: BoxFit.contain,

                                child: StatusLabelButton(

                                  text: data.title,

                                  backgroundColor: data.color,

                                ),

                              ),

                            ),

                            Text(

                              ' :',

                              style: AppTextStyles.secondTitle.copyWith(color: colors.textPrimary),

                            ),

                          ],

                        ),

                        const SizedBox(height: 8),

                        Text(

                          data.kategoriText,

                          style: AppTextStyles.readingText.copyWith(

                            color: colors.textPrimary,

                          ),

                          textAlign: TextAlign.justify,

                        ),

                        const SizedBox(height: 48),



                        // Adult Icons Row

                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: data.adultIcons,

                        ),

                        const Padding(

                          padding: EdgeInsets.symmetric(vertical: 24.0),

                          child: Divider(color: Color(0xFFD9D9D9), thickness: 3),

                        ),



                        // Child Icons Row

                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: data.childIcons,

                        ),

                        const Padding(

                          padding: EdgeInsets.symmetric(vertical: 24.0),

                          child: Divider(color: Color(0xFFD9D9D9), thickness: 3),

                        ),



                        // Bullet Points

                        _buildBulletPoint(data.adultBulletBold, data.adultBulletNormal, colors),

                        const SizedBox(height: 12),

                        _buildBulletPoint(data.childBulletBold, data.childBulletNormal, colors),

                        const SizedBox(height: 16),

                      ],

                    ),

                  ),

                ),

              ),

            ),

            const SizedBox(height: 16),

          ],

        ),

      ),

    );

  }

}