// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Europharm`
  String get title {
    return Intl.message(
      'Europharm',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Got a message whilst in the foreground!`
  String get push_foreground {
    return Intl.message(
      'Got a message whilst in the foreground!',
      name: 'push_foreground',
      desc: '',
      args: [],
    );
  }

  /// `Message data`
  String get message_data {
    return Intl.message(
      'Message data',
      name: 'message_data',
      desc: '',
      args: [],
    );
  }

  /// `Message also contained a notification`
  String get message_contained_notification {
    return Intl.message(
      'Message also contained a notification',
      name: 'message_contained_notification',
      desc: '',
      args: [],
    );
  }

  /// `Firebase messaging token`
  String get firebase_messaging_token {
    return Intl.message(
      'Firebase messaging token',
      name: 'firebase_messaging_token',
      desc: '',
      args: [],
    );
  }

  /// `Нет данных`
  String get no_data {
    return Intl.message(
      'Нет данных',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Server is not reachable. Please verify your internet connection and try again`
  String get server_is_not_reachable {
    return Intl.message(
      'Server is not reachable. Please verify your internet connection and try again',
      name: 'server_is_not_reachable',
      desc: '',
      args: [],
    );
  }

  /// `Problem connecting to the server. Please try again`
  String get problem_connecting_to_the_server {
    return Intl.message(
      'Problem connecting to the server. Please try again',
      name: 'problem_connecting_to_the_server',
      desc: '',
      args: [],
    );
  }

  /// `С вашей помощью мы\nделаем логистику лучше.`
  String get with_your_help_were_doing_logistics_better {
    return Intl.message(
      'С вашей помощью мы\nделаем логистику лучше.',
      name: 'with_your_help_were_doing_logistics_better',
      desc: '',
      args: [],
    );
  }

  /// `Что то пошло не так`
  String get errorGeneral {
    return Intl.message(
      'Что то пошло не так',
      name: 'errorGeneral',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get registration {
    return Intl.message(
      'Регистрация',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Вход`
  String get enter {
    return Intl.message(
      'Вход',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Фото`
  String get photo {
    return Intl.message(
      'Фото',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `Используя это приложение вы соглашаетесь с `
  String get policy_title {
    return Intl.message(
      'Используя это приложение вы соглашаетесь с ',
      name: 'policy_title',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get terms_of_use {
    return Intl.message(
      'Terms of Use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Войдите в `
  String get enter_to {
    return Intl.message(
      'Войдите в ',
      name: 'enter_to',
      desc: '',
      args: [],
    );
  }

  /// `Satti`
  String get satti {
    return Intl.message(
      'Satti',
      name: 'satti',
      desc: '',
      args: [],
    );
  }

  /// `Заказы`
  String get orders {
    return Intl.message(
      'Заказы',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Имя`
  String get first_name {
    return Intl.message(
      'Имя',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Фамилия`
  String get last_name {
    return Intl.message(
      'Фамилия',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Дата рождения`
  String get date_of_birth {
    return Intl.message(
      'Дата рождения',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `ИИН`
  String get iin {
    return Intl.message(
      'ИИН',
      name: 'iin',
      desc: '',
      args: [],
    );
  }

  /// `Личные данные`
  String get personal_data {
    return Intl.message(
      'Личные данные',
      name: 'personal_data',
      desc: '',
      args: [],
    );
  }

  /// `Верификация`
  String get verification {
    return Intl.message(
      'Верификация',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Расписание`
  String get schedule {
    return Intl.message(
      'Расписание',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Профиль`
  String get user {
    return Intl.message(
      'Профиль',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `Загрузить`
  String get load_data {
    return Intl.message(
      'Загрузить',
      name: 'load_data',
      desc: '',
      args: [],
    );
  }

  /// `Выберите`
  String get choose {
    return Intl.message(
      'Выберите',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Ожидайте подтверждения\nаккаунта в течении 24 часов!`
  String get wait_for_account_confirmation {
    return Intl.message(
      'Ожидайте подтверждения\nаккаунта в течении 24 часов!',
      name: 'wait_for_account_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Загрузите фотографии транспорта`
  String get load_photo {
    return Intl.message(
      'Загрузите фотографии транспорта',
      name: 'load_photo',
      desc: '',
      args: [],
    );
  }

  /// `Следующий шаг`
  String get next_step {
    return Intl.message(
      'Следующий шаг',
      name: 'next_step',
      desc: '',
      args: [],
    );
  }

  /// `У вас нет заказов`
  String get no_orders {
    return Intl.message(
      'У вас нет заказов',
      name: 'no_orders',
      desc: '',
      args: [],
    );
  }

  /// `Шаг {step} из 4`
  String steps_count(Object step) {
    return Intl.message(
      'Шаг $step из 4',
      name: 'steps_count',
      desc: '',
      args: [step],
    );
  }

  /// `Пройти верификацию`
  String get do_verification {
    return Intl.message(
      'Пройти верификацию',
      name: 'do_verification',
      desc: '',
      args: [],
    );
  }

  /// `Получите доступ на исполнение заказов`
  String get get_access {
    return Intl.message(
      'Получите доступ на исполнение заказов',
      name: 'get_access',
      desc: '',
      args: [],
    );
  }

  /// `Подтвердите свою личность`
  String get confirm_identity {
    return Intl.message(
      'Подтвердите свою личность',
      name: 'confirm_identity',
      desc: '',
      args: [],
    );
  }

  /// `Введите SMS код подтверждения`
  String get enter_sms_code {
    return Intl.message(
      'Введите SMS код подтверждения',
      name: 'enter_sms_code',
      desc: '',
      args: [],
    );
  }

  /// `Сообщение отправлено на номер {phoneNumber}`
  String code_send_to(Object phoneNumber) {
    return Intl.message(
      'Сообщение отправлено на номер $phoneNumber',
      name: 'code_send_to',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `Сообщение можно переотправить через {timer}`
  String code_can_be_resend(Object timer) {
    return Intl.message(
      'Сообщение можно переотправить через $timer',
      name: 'code_can_be_resend',
      desc: '',
      args: [timer],
    );
  }

  /// `Номер телефона`
  String get phone_number {
    return Intl.message(
      'Номер телефона',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Не менее 8 символов`
  String get less_than_8_symbols {
    return Intl.message(
      'Не менее 8 символов',
      name: 'less_than_8_symbols',
      desc: '',
      args: [],
    );
  }

  /// `Повторите пароль`
  String get repeat_password {
    return Intl.message(
      'Повторите пароль',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Придумайте пароль`
  String get create_password {
    return Intl.message(
      'Придумайте пароль',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `Введите свой номер телефона`
  String get enter_phone_number {
    return Intl.message(
      'Введите свой номер телефона',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона корректно`
  String get enter_phone_correctly {
    return Intl.message(
      'Введите номер телефона корректно',
      name: 'enter_phone_correctly',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Новый пароль`
  String get new_password {
    return Intl.message(
      'Новый пароль',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Текущий пароль`
  String get current_password {
    return Intl.message(
      'Текущий пароль',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `Окей`
  String get okay {
    return Intl.message(
      'Окей',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `История поездок`
  String get ride_history {
    return Intl.message(
      'История поездок',
      name: 'ride_history',
      desc: '',
      args: [],
    );
  }

  /// `Страна`
  String get country {
    return Intl.message(
      'Страна',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Город`
  String get city {
    return Intl.message(
      'Город',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Контактные данные`
  String get contacts {
    return Intl.message(
      'Контактные данные',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Реферальный код`
  String get referal_code {
    return Intl.message(
      'Реферальный код',
      name: 'referal_code',
      desc: '',
      args: [],
    );
  }

  /// `Название компании`
  String get company_name {
    return Intl.message(
      'Название компании',
      name: 'company_name',
      desc: '',
      args: [],
    );
  }

  /// `Номер прав`
  String get car_rights_number {
    return Intl.message(
      'Номер прав',
      name: 'car_rights_number',
      desc: '',
      args: [],
    );
  }

  /// `Срок истечения прав`
  String get car_rights_expire {
    return Intl.message(
      'Срок истечения прав',
      name: 'car_rights_expire',
      desc: '',
      args: [],
    );
  }

  /// `Выберите тип транспорта`
  String get car_type {
    return Intl.message(
      'Выберите тип транспорта',
      name: 'car_type',
      desc: '',
      args: [],
    );
  }

  /// `Год выпуска транспорта`
  String get car_issue_date {
    return Intl.message(
      'Год выпуска транспорта',
      name: 'car_issue_date',
      desc: '',
      args: [],
    );
  }

  /// `Габариты`
  String get car_dimensions {
    return Intl.message(
      'Габариты',
      name: 'car_dimensions',
      desc: '',
      args: [],
    );
  }

  /// `Государственный номер`
  String get government_number {
    return Intl.message(
      'Государственный номер',
      name: 'government_number',
      desc: '',
      args: [],
    );
  }

  /// `Свидетельство о регистрации`
  String get registration_certificate {
    return Intl.message(
      'Свидетельство о регистрации',
      name: 'registration_certificate',
      desc: '',
      args: [],
    );
  }

  /// `Сделайте фото `
  String get make_photo {
    return Intl.message(
      'Сделайте фото ',
      name: 'make_photo',
      desc: '',
      args: [],
    );
  }

  /// `стороны водительского удостоверения`
  String get side_of_rights {
    return Intl.message(
      'стороны водительского удостоверения',
      name: 'side_of_rights',
      desc: '',
      args: [],
    );
  }

  /// `с лицевой `
  String get facial_side {
    return Intl.message(
      'с лицевой ',
      name: 'facial_side',
      desc: '',
      args: [],
    );
  }

  /// `с обратной `
  String get back_side {
    return Intl.message(
      'с обратной ',
      name: 'back_side',
      desc: '',
      args: [],
    );
  }

  /// `и `
  String get and_from {
    return Intl.message(
      'и ',
      name: 'and_from',
      desc: '',
      args: [],
    );
  }

  /// `Сфотографировать`
  String get photograph {
    return Intl.message(
      'Сфотографировать',
      name: 'photograph',
      desc: '',
      args: [],
    );
  }

  /// `Сделайте фото с правами в руках, что бы ваше лицо было видно в кадре`
  String get make_rights_with_face_photo {
    return Intl.message(
      'Сделайте фото с правами в руках, что бы ваше лицо было видно в кадре',
      name: 'make_rights_with_face_photo',
      desc: '',
      args: [],
    );
  }

  /// `Сфотографируйте водительское удостоверение `
  String get make_rights_photo {
    return Intl.message(
      'Сфотографируйте водительское удостоверение ',
      name: 'make_rights_photo',
      desc: '',
      args: [],
    );
  }

  /// `с лицевой стороны`
  String get from_facial_side {
    return Intl.message(
      'с лицевой стороны',
      name: 'from_facial_side',
      desc: '',
      args: [],
    );
  }

  /// `с задней стороны`
  String get from_back_side {
    return Intl.message(
      'с задней стороны',
      name: 'from_back_side',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message(
      'Далее',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте ввод`
  String get inputErrorGeneral {
    return Intl.message(
      'Проверьте ввод',
      name: 'inputErrorGeneral',
      desc: '',
      args: [],
    );
  }

  /// `Пароли не совпадают`
  String get passwordNotMatching {
    return Intl.message(
      'Пароли не совпадают',
      name: 'passwordNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `Реферальный код`
  String get referalCode {
    return Intl.message(
      'Реферальный код',
      name: 'referalCode',
      desc: '',
      args: [],
    );
  }

  /// `Например: AQN43653876`
  String get referalCodeExample {
    return Intl.message(
      'Например: AQN43653876',
      name: 'referalCodeExample',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get signUp {
    return Intl.message(
      'Зарегистрироваться',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `У меня нет реферального кода`
  String get iDontHaveReferalCode {
    return Intl.message(
      'У меня нет реферального кода',
      name: 'iDontHaveReferalCode',
      desc: '',
      args: [],
    );
  }

  /// `Ураа! Последний пункт`
  String get last_part {
    return Intl.message(
      'Ураа! Последний пункт',
      name: 'last_part',
      desc: '',
      args: [],
    );
  }

  /// ` - это личный код приглашения от вашего менеджера.`
  String get referal_code_dialog {
    return Intl.message(
      ' - это личный код приглашения от вашего менеджера.',
      name: 'referal_code_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Понятно`
  String get understandably {
    return Intl.message(
      'Понятно',
      name: 'understandably',
      desc: '',
      args: [],
    );
  }

  /// `Документы`
  String get documents {
    return Intl.message(
      'Документы',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Финансы`
  String get finances {
    return Intl.message(
      'Финансы',
      name: 'finances',
      desc: '',
      args: [],
    );
  }

  /// `Рейтинги`
  String get ratings {
    return Intl.message(
      'Рейтинги',
      name: 'ratings',
      desc: '',
      args: [],
    );
  }

  /// `Как пройти верификацию?`
  String get how_to_pass_verification {
    return Intl.message(
      'Как пройти верификацию?',
      name: 'how_to_pass_verification',
      desc: '',
      args: [],
    );
  }

  /// `Как ввести платежные данные?`
  String get how_to_enter_payment_info {
    return Intl.message(
      'Как ввести платежные данные?',
      name: 'how_to_enter_payment_info',
      desc: '',
      args: [],
    );
  }

  /// `Как изменить пароль?`
  String get how_to_change_password {
    return Intl.message(
      'Как изменить пароль?',
      name: 'how_to_change_password',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get faq {
    return Intl.message(
      'FAQ',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Помощь`
  String get help {
    return Intl.message(
      'Помощь',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Выйти из аккаунта`
  String get log_out {
    return Intl.message(
      'Выйти из аккаунта',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Настройки`
  String get settings {
    return Intl.message(
      'Настройки',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Марка транспорта`
  String get car_mark {
    return Intl.message(
      'Марка транспорта',
      name: 'car_mark',
      desc: '',
      args: [],
    );
  }

  /// `Модель транспорта`
  String get car_model {
    return Intl.message(
      'Модель транспорта',
      name: 'car_model',
      desc: '',
      args: [],
    );
  }

  /// `Поле не должно быть пустым!`
  String get fill_field {
    return Intl.message(
      'Поле не должно быть пустым!',
      name: 'fill_field',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      const Locale('ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
