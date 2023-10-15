package app

import org.http4s.client.Client
import cats.effect.IOApp.Simple
import cats.effect.IO
import cats.effect.kernel.Async
import org.http4s.ember.client.EmberClientBuilder
import fs2.io.net.Network
import org.http4s.ember.server.EmberServerBuilder
import cats.effect.implicits.*
import cats.syntax.all.*
import com.comcast.ip4s.*
import smithy4s.http4s.SimpleRestJsonBuilder
import org.http4s.Request
import org.http4s.Uri
import cats.effect.Concurrent
import org.http4s.EntityDecoder
import org.http4s.circe._

object App extends Simple {

  class AppImpl[F[_]](client: Client[F])(using F: Concurrent[F])
      extends App[F] {

    implicit val dec: EntityDecoder[F, Map[String, Double]] = jsonOf

    def getFxRate(ccy0: Currency, ccy1: Currency): F[FxRate] =
      F.fromEither(
        Uri.fromString(
          s"https://api.frankfurter.app/latest?from=$ccy0&to=$ccy1"
        )
      ).flatMap(uri => client.expect[Map[String, Double]](uri))
        .flatMap(rp =>
          F.fromOption(
            rp.values.toList.headOption.map(FxRate(_)),
            new RuntimeException(s"Unable to get rate for $ccy0$ccy1")
          )
        )
  }

  def runImpl[F[_]: Network](using F: Async[F]): F[Unit] =
    (for {
      client <- EmberClientBuilder.default[F].build

      httpRoutes <- SimpleRestJsonBuilder
        .routes(new AppImpl[F](client))
        .resource

      server <- EmberServerBuilder
        .default[F]
        .withHost(host"localhost")
        .withPort(port"8090")
        .withHttpApp(httpRoutes.orNotFound)
        .build

    } yield server).use(_ => F.never)

  override def run: IO[Unit] = runImpl[IO]

}
