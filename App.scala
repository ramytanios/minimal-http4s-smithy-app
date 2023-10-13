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

object App extends Simple {

  class AppImpl[F[_]](client: Client[F]) extends App[F] {
    override def getRandomCities(): F[RandomCities] = ???
    override def getPopuationOfCity(city: City): F[GetPopulationOutput] = ???
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
