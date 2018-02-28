defmodule PaintSchemer.Paints do
  @moduledoc """
  The Paints context.
  """

  import Ecto.Query, warn: false
  alias PaintSchemer.Repo

  alias PaintSchemer.Paints.Manufacturer

  @doc """
  Returns the list of paint_manufacturers.

  ## Examples

      iex> list_paint_manufacturers()
      [%Manufacturer{}, ...]

  """
  def list_paint_manufacturers do
    Repo.all(Manufacturer)
  end

  @doc """
  Gets a single manufacturer.

  Raises `Ecto.NoResultsError` if the Manufacturer does not exist.

  ## Examples

      iex> get_manufacturer!(123)
      %Manufacturer{}

      iex> get_manufacturer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manufacturer!(id), do: Repo.get!(Manufacturer, id)

  @doc """
  Creates a manufacturer.

  ## Examples

      iex> create_manufacturer(%{field: value})
      {:ok, %Manufacturer{}}

      iex> create_manufacturer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manufacturer(attrs \\ %{}) do
    %Manufacturer{}
    |> Manufacturer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manufacturer.

  ## Examples

      iex> update_manufacturer(manufacturer, %{field: new_value})
      {:ok, %Manufacturer{}}

      iex> update_manufacturer(manufacturer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manufacturer(%Manufacturer{} = manufacturer, attrs) do
    manufacturer
    |> Manufacturer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manufacturer.

  ## Examples

      iex> delete_manufacturer(manufacturer)
      {:ok, %Manufacturer{}}

      iex> delete_manufacturer(manufacturer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manufacturer(%Manufacturer{} = manufacturer) do
    Repo.delete(manufacturer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manufacturer changes.

  ## Examples

      iex> change_manufacturer(manufacturer)
      %Ecto.Changeset{source: %Manufacturer{}}

  """
  def change_manufacturer(%Manufacturer{} = manufacturer) do
    Manufacturer.changeset(manufacturer, %{})
  end

  alias PaintSchemer.Paints.Type

  @doc """
  Returns the list of paint_types.

  ## Examples

      iex> list_paint_types()
      [%Type{}, ...]

  """
  def list_paint_types do
    Repo.all(Type)
  end

  @doc """
  Gets a single type.

  Raises `Ecto.NoResultsError` if the Type does not exist.

  ## Examples

      iex> get_type!(123)
      %Type{}

      iex> get_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_type!(id), do: Repo.get!(Type, id)

  @doc """
  Creates a type.

  ## Examples

      iex> create_type(%{field: value})
      {:ok, %Type{}}

      iex> create_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_type(attrs \\ %{}) do
    %Type{}
    |> Type.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a type.

  ## Examples

      iex> update_type(type, %{field: new_value})
      {:ok, %Type{}}

      iex> update_type(type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_type(%Type{} = type, attrs) do
    type
    |> Type.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Type.

  ## Examples

      iex> delete_type(type)
      {:ok, %Type{}}

      iex> delete_type(type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_type(%Type{} = type) do
    Repo.delete(type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking type changes.

  ## Examples

      iex> change_type(type)
      %Ecto.Changeset{source: %Type{}}

  """
  def change_type(%Type{} = type) do
    Type.changeset(type, %{})
  end

  alias PaintSchemer.Paints.Paint

  @doc """
  Returns the list of paints.

  ## Examples

      iex> list_paints()
      [%Paint{}, ...]

  """
  def list_paints do
    Repo.all paint_associative_expr()
  end

  @doc """
  Gets a single paint.

  Raises `Ecto.NoResultsError` if the Paint does not exist.

  ## Examples

      iex> get_paint!(123)
      %Paint{}

      iex> get_paint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paint!(id), do:  Repo.get! paint_associative_expr(), id
  @doc """
  Creates a paint.

  ## Examples

      iex> create_paint(%{field: value})
      {:ok, %Paint{}}

      iex> create_paint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paint(attrs \\ %{}) do
    %Paint{}
    |> Paint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paint.

  ## Examples

      iex> update_paint(paint, %{field: new_value})
      {:ok, %Paint{}}

      iex> update_paint(paint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paint(%Paint{} = paint, attrs) do
    paint
    |> Paint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Paint.

  ## Examples

      iex> delete_paint(paint)
      {:ok, %Paint{}}

      iex> delete_paint(paint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paint(%Paint{} = paint) do
    Repo.delete(paint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paint changes.

  ## Examples

      iex> change_paint(paint)
      %Ecto.Changeset{source: %Paint{}}

  """
  def change_paint(%Paint{} = paint) do
    Paint.changeset(paint, %{})
  end

  defp paint_associative_expr() do
    from p in Paint,
        join: t in assoc(p, :type),
        join: m in assoc(p, :manufacturer),
        preload: [type: t, manufacturer: m]
  end
end
