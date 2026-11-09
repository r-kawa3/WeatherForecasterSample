# WeatherForecaster

[OpenWeatherMap API](https://openweathermap.org/api) を使って東京の天気予報を表示する iOS サンプルアプリです。  
VIPER アーキテクチャの学習用に作成しました。

- 一覧画面: 3時間ごとの予報(日時と天気アイコン)
- 詳細画面: 天気・説明・気温

## 動作環境

- Xcode 27.1
- iOS 15.0 以上

## セットアップ

### 1. APIキーを設定する

[OpenWeatherMap](https://home.openweathermap.org/users/sign_up) でアカウントを作り、API key を取得します(無料プランで動きます)。

サンプルファイルをコピーして `Secrets.xcconfig` を作ります。

```bash
cp WeatherForecaster/Config/Secrets.example.xcconfig WeatherForecaster/Config/Secrets.xcconfig
```

`Secrets.xcconfig` の `YOUR_API_KEY` を取得したキーに書き換えます。

```
OPENWEATHERMAP_API_KEY = 取得したAPIキー
```

`Secrets.xcconfig` は `.gitignore` に含まれているのでコミットされません。

### 2. Team を設定する

1. `WeatherForecaster/WeatherForecaster.xcodeproj` を Xcode で開く
2. TARGETS の `WeatherForecaster` → **Signing & Capabilities** を開く
3. **Team** で自分の Apple ID(Personal Team で可)を選ぶ
4. 実機で動かす場合、Bundle Identifier(`com.example.WeatherForecaster`)を自分用の一意な値に変更する

シミュレータで動かすだけなら Team の設定は不要です。

### 3. 実行する

スキームを `WeatherForecaster` にして、シミュレータを選んで Run(⌘R)します。

## APIキーの受け渡し

```
Config/Secrets.xcconfig            OPENWEATHERMAP_API_KEY = ...
        ↓ #include? (Base.xcconfig)
ビルド設定 $(OPENWEATHERMAP_API_KEY)
        ↓
Info.plist                         OpenWeatherMapAPIKey
        ↓
OpenWeatherMapAPI.apiKey           Bundle.main から読み出し
```

`Secrets.xcconfig` がなくてもビルドは通りますが、キーが空になるため予報は表示されません。

## 構成(VIPER)

```
WeatherForecaster/
├── Config/                         ビルド設定(xcconfig)
└── WeatherForecaster/
    ├── Application/
    │   └── Delegate/               AppDelegate と起動時の Presenter / Router
    ├── Domain/
    │   └── GetForecastResult/      Interactor(予報取得のユースケース)
    ├── Infra/
    │   └── OpenWeatherMapClient/   API リクエスト定義・通信・Entity
    └── Modules/
        ├── WeatherForecastResult/  一覧画面(View / Presenter / Router)
        └── WeatherForecastDetail/  詳細画面(View / Presenter / Router)
```

| 層 | 役割 | 主なファイル |
|---|---|---|
| View | 画面表示とユーザー操作の受け取り | `WeatherForecastResultView.swift`, `WeatherForecastDetailView.swift` |
| Interactor | ビジネスロジック(予報の取得) | `GetForecastResultInteractor.swift` |
| Presenter | View と Interactor の仲介、表示データの受け渡し | `WeatherForecastResultPresenter.swift`, `WeatherForecastDetailPresenter.swift` |
| Entity | API レスポンスのモデル | `ForecastEntity.swift` |
| Router | 画面の組み立てと遷移 | `AppRouter.swift`, `WeatherForecastResultRouter.swift`, `WeatherForecastDetailRouter.swift` |

画面遷移の流れ:

1. `AppDelegate` → `AppPresenter` → `AppRouter` が一覧画面を `UINavigationController` に載せて表示
2. 一覧画面の `viewWillAppear` で Presenter が Interactor に予報取得を依頼
3. Interactor が `OpenWeatherMapClient` 経由で API を呼び、結果を Presenter → View に返す
4. セルをタップすると Presenter → Router が詳細画面を push

## ライセンス

- **ソースコード**: [MIT License](LICENSE)
- 天気のデータは [OpenWeather](https://openweathermap.org/) の API から取得します。データの利用条件は OpenWeather の規約に従います。詳細画面の下に「Weather data provided by OpenWeather」と出し、押すと openweathermap.org を開きます。
